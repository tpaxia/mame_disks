-- license:BSD-3-Clause
-- copyright-holders: Salvatore Paxia
local m=manager.machine;local c=m.devices[':maincpu'];local s=c.spaces.program
local g=m.devices[':bus:console:goino'];local f=m.devices[':bus:floppy:flodi']
local dir="/Users/paxia/Projects/P6066/analysis/hardware/hdu/boot-current-keyboard/"
local last='';local done=false;local frames=0
local function state()
 return string.format('PC=%04X LEVEL=%d STOPPED=%d INVALID=%d sectors=%d display=%d ready=%d lamps=%04X write=%d erase=%d',c.state.PC.value,c.state.LEVEL.value,c.state.STOPPED.value,c.state.INVALID.value,f:output('sectors_read'):get(),g:output('display_strobes'):get(),g:output('display_ready'):get(),g:output('console_lamps'):get(),f:output('write_gate'):get(),f:output('erase_gate'):get())
end
local function finish()
 if done then return end;done=true
 print(string.format('FINAL time=%.9f %s',m.time:as_double(),state()))
 local out=assert(io.open(dir..'ram.bin','wb'))
 for a=0,0xbfff do local w=s:read_u16(a);out:write(string.char(w>>8,w&255)) end;out:close()
 local regs=assert(io.open(dir..'registers.txt','w'))
 for name,v in pairs(c.state) do regs:write(string.format('%s %X\n',name,v.value)) end;regs:close()
 m.video:snapshot()
end
-- Host command queue drives only ordinary emulated keys and console buttons.
local ports=m.ioport.ports
local prefix=':bus:console:goino:keyboard:'
local captured=false
local function beforehd()
 if not captured and m.time:as_double()>75.7 then
  captured=true;local out=assert(io.open(dir..'before-hd.bin','wb'))
  for a=0,0xbfff do local w=s:read_u16(a);out:write(string.char(w>>8,w&255)) end;out:close()
 end
end
local events={};local next_event=1;local consumed=0;local available=25
local function add(port,key,value,when) events[#events+1]={when,port,key,value} end
local function type_line(text,now)
 local t=math.max(now+0.2,available)
 print('TYPE',t,text)
 for ch in text:gmatch('.') do
  local name=ch:upper();local port='KEYS0';local shift=ch:match('[A-Z]')~=nil
  if ch==' ' then name='Space';port='KEYS1'
  elseif ch==',' then name='Comma';port='KEYS1'
  elseif ch=='=' then name='Minus';port='KEYS1';shift=true
  elseif ch=='*' then name='Colon';port='KEYS1';shift=true
  elseif ch:match('[6-9]') then port='KEYS1' end
  if shift then add(prefix..'MODIFIERS','Left Shift',1,t) end
  add(prefix..port,name,1,t+0.04);add(prefix..port,name,0,t+0.14)
  if shift then add(prefix..'MODIFIERS','Left Shift',0,t+0.18) end
  t=t+0.3
 end
 add(prefix..'KEYS1','End of line',1,t+0.05);add(prefix..'KEYS1','End of line',0,t+0.15)
 available=t+5
end
local function inputs()
 local now=m.time:as_double()
 if now<25 then return end
 local file=io.open(dir..'queue.txt','r')
 if file then
  local index=0
  for line in file:lines() do
   index=index+1
   if index>consumed then
    if line=='CONTINUE' then
     local t=math.max(now+0.2,available);add(':bus:console:goino:BUTTONS','Continue',1,t);add(':bus:console:goino:BUTTONS','Continue',0,t+0.2);available=t+5
    elseif line=='MODE' then
     local t=math.max(now+0.2,available);add(prefix..'MODIFIERS','KB Mode',1,t);add(prefix..'MODIFIERS','KB Mode',0,t+0.2);available=t+2
    elseif line:sub(1,4)=='KEY ' then
     local port,key=line:sub(5):match('([^|]+)|(.+)');assert(port and key);local t=math.max(now+0.2,available);add(prefix..port,key,1,t);add(prefix..port,key,0,t+0.2);available=t+2
    elseif line:sub(1,5)=='WAIT ' then available=math.max(now,available)+assert(tonumber(line:sub(6)))
    elseif line=='EXIT' then finish();m:exit()
    elseif line:sub(1,5)=='TYPE ' then type_line(line:sub(6),now)
    end
   end
  end
  consumed=index;file:close()
 end
 while events[next_event] and now>=events[next_event][1] do
  local e=events[next_event];ports[e[2]].fields[e[3]]:set_value(e[4]);next_event=next_event+1
 end
end
emu.register_frame_done(function()
 frames=frames+1;beforehd();inputs();
 local signature=string.format('%d/%d/%d/%d',g:output('console_lamps'):get(),g:output('display_strobes'):get(),f:output('write_gate'):get(),c.state.STOPPED.value)
 if signature~=last or frames%300==0 then print(string.format('STATE time=%.9f %s',m.time:as_double(),state()));last=signature end
 if c.state.STOPPED.value~=0 or m.time:as_double()>=60 then finish();m:exit() end
end)
boot_stop=emu.add_machine_stop_notifier(finish)

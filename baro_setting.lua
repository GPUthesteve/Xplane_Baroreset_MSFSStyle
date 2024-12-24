

--GPUthesteve's "MSFS Altimeter Reset" key
--Behaves like MSFS reset button that works only at 18K feet, will improve this later
--written on 241218

-- set initial variables
dataref("QNHPilot","sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot","writable")
dataref("QNHCoPilot","sim/cockpit2/gauges/actuators/barometer_setting_in_hg_copilot","writable")
dataref("QNHStandby","sim/cockpit2/gauges/actuators/barometer_setting_in_hg_stby","writable")
dataref("RA_1","sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_pilot","readonly")
dataref("RA_2","sim/cockpit2/gauges/indicators/radio_altimeter_height_ft_copilot","readonly")
dataref("GetSimver","sim/version/xplane_internal_version","readonly")
dataref("legacyQNH","sim/weather/barometer_sealevel_inhg","readonly")

function getqnh12() --TBD
	if GetSimver >= 120000 then 
	dataref("GetQNH_XP12","sim/weather/region/qnh_pas","readonly")
	QNH_Proc = GetQNH_XP12 * 0.0002953
	else dataref("QNH_Proc","sim/weather/barometer_sealevel_inhg","readonly") --when Xplane deprecated this, i will add some logic later
	return 0
	end
end

function main()
	if RA_1 >= 18000 then
        QNHCoPilot = 29.92
		QNHPilot = 29.92
		QNHStandby	= 29.92
    else 
		QNHCoPilot = legacyQNH
		QNHPilot = legacyQNH
		QNHStandby = legacyQNH
	end
	return 0
end
create_command("FlyWithLua/MSFSBaroSet/AltimeterReset","Altimeter (Reset)",
[[main()]],
"", -- do nothing if the button is held down
"") -- do nothing if the button is released

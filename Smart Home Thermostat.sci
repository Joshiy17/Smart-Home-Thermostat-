
--> clear;

--> // ======= Simulation Setup =======

--> hours = 24;

--> time = 0:1:hours;

--> n = length(time);

--> // ======= Outside Temperature (Summer Profile) =======

--> T_outside = 30 + 5 * sin(%pi * time / 12); // Simulate 25°C–35°C wave

--> T_room = zeros(1, n);

--> T_room(1) = 28; // Starting room temperature

--> // ======= Comfort Limits =======

--> T_min = 20;

--> T_max = 24;

--> // ======= Energy Use and Cost Settings =======

--> cool_power = 2.5; // Cooler power usage per hour

--> heat_power = 2.0; // Heater (rare in summer)

--> energy_used = zeros(1, n);

--> cost_incurred = zeros(1, n);

--> energy_cost = zeros(1, n);

--> // ======= Time-of-use Pricing =======

--> for i = 1:n
  >     if time(i) >= 17 & time(i) <= 21 then
  >         energy_cost(i) = 12; // ₹12/unit during peak hours
  >     else
  >         energy_cost(i) = 6;  // ₹6/unit otherwise
  >     end
  > end

--> // ======= Simulation Logic =======

--> for i = 2:n
  >     heat_gain = 0.1 * (T_outside(i) - T_room(i-1)); // Heat entering from outside
  >     if T_room(i-1) > T_max then
  >         delta_T = -1.5; // Cooler ON
  >         energy_used(i) = cool_power;
  >     elseif T_room(i-1) < T_min then
  >         delta_T = 1.2;  // Heater ON (not likely in summer)
  >         energy_used(i) = heat_power;
  >     else
  >         delta_T = 0;
  >         energy_used(i) = 0;
  >     end
  >     // Update room temperature and cost
  >     T_room(i) = T_room(i-1) + delta_T + heat_gain;
  >     cost_incurred(i) = energy_used(i) * energy_cost(i);
  > end

--> // ======= Final Totals =======

--> total_energy = sum(energy_used);

--> total_cost = sum(cost_incurred);

--> disp("✅ Total Energy Used: " + string(total_energy) + " units");

  "✅ Total Energy Used: 30 units"

--> disp("💰 Total Cost: ₹" + string(total_cost));

  "í ½í²° Total Cost: â‚¹195"

--> // ==================================================

--> // =============== 📈 PLOTTING =======================

--> // ==================================================

--> // --------- Plot 1: Room vs Outside Temperature ---------

--> scf(0); clf();

--> plot(time, T_room, 'b-', time, T_outside, 'r--');

--> xgrid();

--> xlabel("Time (Hours)", "fontsize", 3);

--> ylabel("Temperature (°C)", "fontsize", 3);

--> title("🌞 Room vs Outside Temperature (Summer)", "fontsize", 4);

--> legend(["Room Temperature", "Outside Temperature"], "in_upper_left");

--> // --------- Plot 2: Hourly Energy Used (Cooling) ---------

--> scf(1); clf();

--> plot(time, energy_used, 'g-', "thickness", 2);

--> xgrid();

--> xlabel("Time (Hours)", "fontsize", 3);

--> ylabel("Energy Used (Units)", "fontsize", 3);

--> title("❄️ Hourly Energy Consumption (Cooling)", "fontsize", 4);

--> // --------- Plot 3: Hourly Cost in ₹ ---------

--> scf(2); clf();

--> plot(time, cost_incurred, 'm-', "thickness", 2);

--> xgrid();

--> xlabel("Time (Hours)", "fontsize", 3);

--> ylabel("Electricity Cost (₹)", "fontsize", 3);

--> title("💸 Hourly Electricity Cost (Summer)", "fontsize", 4);
at line     2 of executed string 

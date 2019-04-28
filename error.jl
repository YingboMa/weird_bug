using OrdinaryDiffEq, DiffEqCallbacks

f = function (du,u,p,t)
  du[1] = u[2]
  du[2] = -9.81
end

condition = function (u,t,integrator) # Event when event_f(u,t,k) == 0
  u[1]
end

affect! = nothing
affect_neg! = function (integrator)
  integrator.u[2] = -integrator.u[2]
end

callback = ContinuousCallback(condition,affect!,affect_neg!,interp_points=100)

u0 = [50.0,0.0]
tspan = (0.0,15.0)
prob = ODEProblem(f,u0,tspan)

sol = solve(prob,BS3(),callback=callback)

defmodule CPSolver.SatSolver.VariableSelector.DLIS do
  @moduledoc """
  Dynamic Largest Individual Sum.

  For a given variable x:
  – C(x,p) – # of unresolved clauses in which x appears positively
  – C(x,n) - # of unresolved clauses in which x appears negatively
  – Let x be the literal for which Cx,p is maximal
  – Let y be the literal for which Cy,n is maximal
  – If Cx,p > Cy,n choose x and assign it TRUE
  – Otherwise choose y and assign it FALSE
  """
  use CPSolver.Search.VariableSelector
  alias CPSolver.Propagator.ConstraintGraph
  alias CPSolver.Variable.View
  alias CPSolver.Utils


  @impl true
  def select(_variables, %{constraint_graph: c_graph} = _space_data, _opts) do
    ConstraintGraph.vertices(c_graph)
    |> Enum.reduce(Map.new(), fn
      {:variable, _}, acc ->
        acc

      {:propagator, _p_id} = p_vertex, acc ->
        propagator = ConstraintGraph.get_propagator(c_graph, p_vertex)

          Enum.reduce(propagator.args, acc, fn arg, acc2 ->
            view? = is_struct(arg, View)
            var = view? && arg.variable || arg

            sign = (view? && -1) || 1

            {_, updated_acc} = Map.get_and_update(acc2, {var, sign}, fn current_value ->
              new_value = (current_value && current_value + 1) || 1
              {current_value, new_value}
            end)
            updated_acc
          end)
    end)
    |> Enum.flat_map(fn {{var, _sign}, count} -> Interface.fixed?(var) && [] || [{var, count}] end)
    |> Utils.maximals(
      fn {_var, count} ->
        count
      end
    )
    |> Enum.map(fn {var, _count} ->
      var end)
  end

end
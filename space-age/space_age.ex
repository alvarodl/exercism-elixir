defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @earth_year 31_557_600

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    cond do
      planet == :earth -> seconds / @earth_year
      planet == :mercury -> seconds / (@earth_year * 0.2408467)
      planet == :venus -> seconds / (@earth_year * 0.61519726)
      planet == :mars -> seconds / (@earth_year * 1.8808158)
      planet == :jupiter -> seconds / (@earth_year * 11.862615)
      planet == :saturn -> seconds / (@earth_year * 29.447498)
      planet == :uranus -> seconds / (@earth_year * 84.016846)
      planet == :neptune -> seconds / (@earth_year * 164.79132)
    end
  end
end

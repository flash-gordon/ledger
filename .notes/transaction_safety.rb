
# does not work
counter = repo.find_counter(conter_id)

repo.update_counter(counter_id, counter.count + 1)

# does not work either

counter = repo.find_counter(conter_id)

repo.transaction do
  repo.update_counter(counter_id, counter.count + 1)
end

# does not work too by default (i.e. with READ COMMITED in PG)

repo.transaction do
  counter = repo.find_counter(conter_id)

  repo.update_counter(counter_id, counter.count + 1)
end

# works fine

def update_counter(counter_id)
  counters.
    by_pk(counter_id).
    changeset(
      :update,
      value: counters[:value] + 1
    ).
    commit
end

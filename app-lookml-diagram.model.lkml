connection: "thelook"

view: orders {
  dimension: id {}
}

view: orders2 {
  dimension: id {}
}

view: orders3 {
  dimension: id {}
}

explore: orders_test {
  view_name: orders
  join: orders2 {
    from: orders
    sql_on: ${orders2.id} = ${orders.id} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: orders3 {
    from: orders
    fields: []
    sql_on: LEFT JOIN UNNEST(${orders.id}) ;;
    relationship: one_to_one
    type: left_outer
  }
}

explore: orders2 {
  view_name: orders2
}

explore: orders3 {
  view_name: orders3
}

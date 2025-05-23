connection: "thelook"

view: orders {
  dimension: id {}
}

view: orders_test {}

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
    sql: LEFT JOIN UNNEST(${orders.id}) ;;
    relationship: one_to_one
    type: left_outer
  }
}

explore: orders {
  view_name: orders
}

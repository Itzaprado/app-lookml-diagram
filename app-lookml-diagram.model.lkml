connection: "thelook"

view: orders {
  dimension: id {}
}

explore: orders {
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
    sql: LEFT JOIN UNNEST(${orders.id}) ;;
    relationship: one_to_one
    type: left_outer
  }
}

explore: order_items {
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
    sql: LEFT JOIN UNNEST(${orders.id}) ;;
    relationship: one_to_one
    type: left_outer
  }
}

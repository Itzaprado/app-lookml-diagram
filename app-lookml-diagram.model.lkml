connection: "thelook"

view: orders_test {
  dimension: id {}
}

explore: orders_test {
  view_name: orders_test
  join: orders2 {
    from: orders_test
    sql_on: ${orders2.id} = ${orders_test.id} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: orders3 {
    from: orders_test
    fields: []
    sql: LEFT JOIN UNNEST(${orders_test.id}) ;;
    relationship: one_to_one
    type: left_outer
  }
}

connection: "thelook"

view: orders_test {
  dimension: id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }
  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }
  dimension: order_price {
    type: number
    sql: ${TABLE}.order_price ;;
  }
  measure: count {
    type: count
  }
}

view: orders2 {
  dimension: id {
    type: string
  }
}

view: orders3 {
  dimension: id {
    type: string
  }
}

explore: orders_test {
  join: orders2 {
    from: orders_test
    sql_on: ${orders2.id} = ${orders_test.id} ;;
    relationship: one_to_one
    type: left_outer
  }
  join: orders3 {
    from: orders_test
    sql_on: LEFT JOIN UNNEST(${orders_test.id}) ;;
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

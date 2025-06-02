connection: "thelook"

view: orders {
  dimension: id {}
}

view: billion_orders {
  sql_table_name: demo_db.billion_orders ;;

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }
  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }
  dimension: order_price {
    type: number
    sql: ${TABLE}.order_price ;;
  }
  measure: count {
    type: count
    drill_fields: [orders.id]
  }
}

view: users {
  sql_table_name: demo_db.users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
    drill_fields: [state,city]
  }
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: email {
    type: string
    label: "email"
    tags: ["email"]
    sql: ${TABLE}.email ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }
  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }
  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      saralooker.count,
      sindhu.count,
      user_data.count
    ]
  }

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

explore: billion_orders {
  join: orders {
    type: left_outer
    sql_on: ${billion_orders.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: LEFT JOIN UNNEST(${orders.id})  ;;
    relationship: many_to_one
  }
}

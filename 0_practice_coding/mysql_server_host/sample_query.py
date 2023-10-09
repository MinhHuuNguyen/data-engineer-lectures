import json
import mysql.connector


if __name__ == '__main__':
    with open('config.json', 'r') as f:
        config = json.load(f)

    mysql_db = mysql.connector.connect(
        host=config['host'],
        database=config['db_name'],
        user=config['username'],
        password=config['password']
    )
    mysql_cursor = mysql_db.cursor()
    query = f'''
        SELECT 
            *
        FROM
            customers
        WHERE
            customerNumber = 103
    '''
    mysql_cursor.execute(query)
    result = mysql_cursor.fetchall()

    print(result)
    mysql_db.close()

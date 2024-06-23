from flask import Flask, render_template, request
from flask_mysqldb import MySQL
import os
from dotenv import load_dotenv

load_dotenv()


app = Flask(__name__)

app.config['MYSQL_HOST'] = 'mysql'
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD')
app.config['MYSQL_DATABASE'] = os.getenv('MYSQL_DATABASE')
app.config['MYSQL_UNIX_SOCKET'] = '/var/run/mysqld/mysqlx.sock'

mysql = MySQL(app)


@app.route("/", methods=['GET', 'POST'])
def index():

    if request.method == 'POST':

        user_details = request.form
        fname = user_details['f_name']
        lname = user_details['l_name']
        p_no = user_details['phone_no']
        cur = mysql.connection.cursor()
        cur.execute("use " + app.config['MYSQL_DATABASE'] + ";")
        cur.execute("insert into info(f_name,l_name,pho_no) values(%s,%s,%s)",
                    (fname, lname, p_no))
        mysql.connection.commit()
        cur.close()
        return render_template('user.html')

    return render_template('index.html')

@app.route("/summary", methods=['GET'])
def summary():
    cur = mysql.connection.cursor()
    cur.execute("use " + app.config['MYSQL_DATABASE'] + ";")
    cur.execute("SELECT f_name, l_name, pho_no FROM info")
    data = cur.fetchall()
    cur.close()
    return render_template('summary.html', data=data)



@app.route("/recipes", methods=['GET'])
def recipes():
    cur = mysql.connection.cursor()
    cur.execute("use " + app.config['MYSQL_DATABASE'] + ";")
    cur.execute("SELECT id, title, image_url FROM recipes")
    data = cur.fetchall()
    cur.close()
    return render_template('recipes.html', data=data)

@app.route("/recipe/<int:recipe_id>", methods=['GET'])
def recipe(recipe_id):
    cur = mysql.connection.cursor()
    cur.execute("use " + app.config['MYSQL_DATABASE'] + ";")
    cur.execute("SELECT * FROM recipes WHERE id = %s", (recipe_id,))
    recipe_data = cur.fetchone()
    cur.close()

    # Assuming recipe_data[4] is the ingredients and recipe_data[5] is the instructions
    ingredients = recipe_data[4].split(', ')
    instructions = recipe_data[5].split('. ')

    processed_recipe_data = {
        'title': recipe_data[1],
        'image_url': recipe_data[2],
        'description': recipe_data[3],
        'ingredients': ingredients,
        'instructions': instructions
    }

    return render_template('recipe.html', recipe=processed_recipe_data)
if __name__ == '__main__':
    app.run(debug=True)

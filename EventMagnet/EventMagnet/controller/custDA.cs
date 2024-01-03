using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;

using model = EventMagnet.modal;
using System.Xml.Linq;
using System.Collections;
using System.Security.Policy;
using System.Web.Configuration;
using EventMagnet.modal;

namespace EventMagnet.controller
{
    public class custDA
    {
        string cs = Global.CS;

        public custDA() { }

        public int SaveCustomerToDatabase(modal.customer newCustomer)
        {
            int result = 0;

            try
            {
                modal.customer customerValue = newCustomer;

                string sql = "INSERT INTO Customer (name, birthdate, phone, ic_no, email, gender, address_one, address_two, postcode, city, state, country, status) VALUES (@name, @birthdate, @phone, @ic_no, @email, @gender, @address_one, @address_two, @postcode, @city, @state, @country, @status)";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@name", customerValue.name);
                cmd.Parameters.AddWithValue("@birthdate", customerValue.birthdate);
                cmd.Parameters.AddWithValue("@phone", customerValue.phone);
                cmd.Parameters.AddWithValue("@ic_no", customerValue.ic_no);
                cmd.Parameters.AddWithValue("@email", customerValue.email);
                cmd.Parameters.AddWithValue("@gender", customerValue.gender);
                cmd.Parameters.AddWithValue("@address_one", customerValue.address_one);
                cmd.Parameters.AddWithValue("@address_two", customerValue.address_two);
                cmd.Parameters.AddWithValue("@postcode", customerValue.postcode);
                cmd.Parameters.AddWithValue("@city", customerValue.city);
                cmd.Parameters.AddWithValue("@state", customerValue.state);
                cmd.Parameters.AddWithValue("@country", customerValue.country);
                cmd.Parameters.AddWithValue("@status", customerValue.status);
                

                conn.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                conn.Close();

                if (rowAffected > 0)
                {
                    result = 1;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return result;
        }

        public List<modal.customer> retrieveCustomersFromDatabase()
        {
            List<modal.customer> customerList = new List<modal.customer>();

            try
            {
                string sql = "SELECT * FROM Customer WHERE status = 1";
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    modal.customer customerItem = new modal.customer();

                    customerItem.id = Convert.ToInt32(reader["id"]);
                    customerItem.name = Convert.ToString(reader["name"]);
                    customerItem.birthdate = Convert.ToDateTime(reader["birthdate"]);
                    customerItem.phone = Convert.ToString(reader["phone"]);
                    customerItem.ic_no = Convert.ToString(reader["ic_no"]);
                    customerItem.email = Convert.ToString(reader["email"]);
                    customerItem.gender = Convert.ToString(reader["gender"]);
                    customerItem.address_one = Convert.ToString(reader["address_one"]);
                    customerItem.address_two = Convert.ToString(reader["address_two"]);
                    customerItem.postcode = Convert.ToString(reader["postcode"]);
                    customerItem.city = Convert.ToString(reader["city"]);
                    customerItem.state = Convert.ToString(reader["state"]);
                    customerItem.country = Convert.ToString(reader["country"]);
                    customerItem.status = Convert.ToByte(reader["status"]);

                    customerList.Add(customerItem);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return customerList;
        }

        public modal.customer retrieveCustomerById(int customerId)
        {
            modal.customer customerValue = new modal.customer();

            try
            {
                string sql = "SELECT * FROM Customer WHERE status = 1 AND id = @customerId";
                using (SqlConnection conn = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    cmd.Parameters.AddWithValue("@customerId", customerId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            customerValue.id = Convert.ToInt32(reader["id"]);
                            customerValue.name = Convert.ToString(reader["name"]);
                            customerValue.birthdate = Convert.ToDateTime(reader["birthdate"]);
                            customerValue.phone = Convert.ToString(reader["phone"]);
                            customerValue.ic_no = Convert.ToString(reader["ic_no"]);
                            customerValue.email = Convert.ToString(reader["email"]);
                            customerValue.gender = Convert.ToString(reader["gender"]);
                            customerValue.address_one = Convert.ToString(reader["address_one"]);
                            customerValue.address_two = Convert.ToString(reader["address_two"]);
                            customerValue.postcode = Convert.ToString(reader["postcode"]);
                            customerValue.city = Convert.ToString(reader["city"]);
                            customerValue.state = Convert.ToString(reader["state"]);
                            customerValue.country = Convert.ToString(reader["country"]);
                            customerValue.status = Convert.ToByte(reader["status"]);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return customerValue;
        }

        public bool softDeleteCustomer(int customerId)
        {
            bool success = false;

            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var existingCustomer = db.customers.Find(customerId);

                    if (existingCustomer != null)
                    {
                        existingCustomer.status = 0;
                        db.SaveChanges();
                        success = true;
                    }
                    else
                    {
                        Debug.WriteLine($"Customer with ID {customerId} not found.");
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }

            return success;
        }
    }
}
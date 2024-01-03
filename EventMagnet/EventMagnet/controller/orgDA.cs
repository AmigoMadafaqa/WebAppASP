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
    public class orgDA
    {
        string cs = Global.CS;

        public orgDA() { }

        public int SaveOrganizationToDatabase(modal.organization newOrganization)
        {
            int result = 0;

            try
            {
                modal.organization organizationValue = newOrganization;

                string sql = "INSERT INTO organization (name, descp, phone, website_link, email, address_one, address_two, postcode, city, state, country, status) VALUES (@name, @descp, @phone, @website_link, @email, @address_one, @address_two, @postcode, @city, @state, @country, @status)";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@name", organizationValue.name);
                cmd.Parameters.AddWithValue("@descp", organizationValue.descp);
                cmd.Parameters.AddWithValue("@website_link", organizationValue.website_link);
                cmd.Parameters.AddWithValue("@phone", organizationValue.phone);
                cmd.Parameters.AddWithValue("@email", organizationValue.email);
                cmd.Parameters.AddWithValue("@address_one", organizationValue.address_one);
                cmd.Parameters.AddWithValue("@address_two", organizationValue.address_two);
                cmd.Parameters.AddWithValue("@postcode", organizationValue.postcode);
                cmd.Parameters.AddWithValue("@city", organizationValue.city);
                cmd.Parameters.AddWithValue("@state", organizationValue.state);
                cmd.Parameters.AddWithValue("@country", organizationValue.country);
                cmd.Parameters.AddWithValue("@status", organizationValue.status);


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

        public List<modal.organization> retrieveOrganizationsFromDatabase()
        {
            List<modal.organization> organizationList = new List<modal.organization>();

            try
            {
                string sql = "SELECT * FROM organization WHERE status = 1";
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    modal.organization organizationItem = new modal.organization();

                    organizationItem.id = Convert.ToInt32(reader["id"]);
                    organizationItem.name = Convert.ToString(reader["name"]);
                    organizationItem.email = Convert.ToString(reader["email"]);
                    organizationItem.website_link = Convert.ToString(reader["website_link"]);
                    organizationItem.descp = Convert.ToString(reader["descp"]);
                    organizationItem.phone = Convert.ToString(reader["phone"]);
                    organizationItem.address_one = Convert.ToString(reader["address_one"]);
                    organizationItem.address_two = Convert.ToString(reader["address_two"]);
                    organizationItem.postcode = Convert.ToString(reader["postcode"]);
                    organizationItem.city = Convert.ToString(reader["city"]);
                    organizationItem.state = Convert.ToString(reader["state"]);
                    organizationItem.country = Convert.ToString(reader["country"]);
                    organizationItem.status = Convert.ToByte(reader["status"]);

                    organizationList.Add(organizationItem);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return organizationList;
        }

        public modal.organization retrieveOrganizationById(int organizationId)
        {
            modal.organization organizationValue = new modal.organization();

            try
            {
                string sql = "SELECT * FROM Organization WHERE status = 1 AND id = @organizationId"; // Change table name to your actual organization table name
                using (SqlConnection conn = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    cmd.Parameters.AddWithValue("@organizationId", organizationId);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            organizationValue.id = Convert.ToInt32(reader["id"]);
                            organizationValue.name = Convert.ToString(reader["name"]);
                            organizationValue.email = Convert.ToString(reader["email"]);
                            organizationValue.website_link = Convert.ToString(reader["website_link"]);
                            organizationValue.descp = Convert.ToString(reader["descp"]);
                            organizationValue.phone = Convert.ToString(reader["phone"]);
                            organizationValue.address_one = Convert.ToString(reader["address_one"]);
                            organizationValue.address_two = Convert.ToString(reader["address_two"]);
                            organizationValue.postcode = Convert.ToString(reader["postcode"]);
                            organizationValue.city = Convert.ToString(reader["city"]);
                            organizationValue.state = Convert.ToString(reader["state"]);
                            organizationValue.country = Convert.ToString(reader["country"]);
                            organizationValue.status = Convert.ToByte(reader["status"]);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return organizationValue;
        }

        public bool softDeleteOrganization(int organizationId)
        {
            bool success = false;

            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var existingOrganization = db.organizations.Find(organizationId);

                    if (existingOrganization != null)
                    {
                        existingOrganization.status = 0;
                        db.SaveChanges();
                        success = true;
                    }
                    else
                    {
                        Debug.WriteLine($"Organization with ID {organizationId} not found.");
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
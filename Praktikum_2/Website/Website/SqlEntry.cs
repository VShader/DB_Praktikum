﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Website
{
    public class SqlEntry
    {
        public SqlDataReader getReader(String query)
        {
            connection = new SqlConnection(sqlAddress);
            var command = new SqlCommand(query, connection);
            connection.Open();
            return command.ExecuteReader();
        }

        public Object getScalar(String query)
        {
            connection = new SqlConnection(sqlAddress);
            var command = new SqlCommand(query, connection);
            connection.Open();
            return command.ExecuteScalar();
        }
        public void Close()
        {
            connection.Close();
        }
        private const string sqlAddress = @"Data Source=TEST-PC\SQLEXPRESS;Initial Catalog=Praktikum;Persist Security Info=True;User ID=SA;Password=sa2014";
        private SqlConnection connection;

    }
}
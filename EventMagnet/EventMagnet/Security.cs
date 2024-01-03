using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Security.Principal;
using System.Threading;
using System.Web.Security;

namespace EventMagnet
{
    public class Security
    {
        public static string GetHash(string strPass)
        {
            //convert pass in string format into binary
            byte[] binPass = Encoding.Default.GetBytes(strPass);

            //enable hash function
            SHA256 sha = SHA256.Create();

            //calculate hash value based on 
            byte[] binHash = sha.ComputeHash(binPass);

            //convert hash in binary format back to string
            string strHash = Convert.ToBase64String(binHash);

            return strHash;
        }

        public static bool VerifyHash(string enteredPassword, string storedHash)
        {
            string enteredHash = GetHash(enteredPassword);

            //Compare the hashed passwords in a case-insensitive manner
            return string.Equals(enteredHash, storedHash, StringComparison.OrdinalIgnoreCase);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace StackIt.Models
{
    public class Question
    {
        public string Title { get; set; }
        public string ShortDescription { get; set; }
        public string Author { get; set; }
        public string DetailUrl { get; set; }
    }
}
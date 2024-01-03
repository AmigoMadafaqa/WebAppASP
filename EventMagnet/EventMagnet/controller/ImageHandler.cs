using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;

namespace EventMagnet.controller
{
    public class ImageHandler
    {
        private Bitmap source;

        public ImageHandler(Stream stream)
        {
            source = new Bitmap(stream);
        }

        public ImageHandler(string filename)
        {
            source = new Bitmap(filename);
        }

        public ImageHandler(Byte[] bytes)
        {
            source = (Bitmap)new ImageConverter().ConvertFrom(bytes);
        }

        public void Square()
        {
            int size = Math.Min(source.Width, source.Height);

            Bitmap target = new Bitmap(size, size);
            using (Graphics g = Graphics.FromImage(target))
            {
                g.CompositingQuality = CompositingQuality.HighSpeed;
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.CompositingMode = CompositingMode.SourceCopy;
                g.DrawImage(source, (size - source.Width) / 2, (size - source.Height) / 2, source.Width, source.Height);
                source = target;
            }
        }

        public void Resize(int size)
        {
            int width, height;

            if (source.Width > source.Height)
            {
                width = size;
                height = source.Height * size / source.Width;
            }
            else
            {
                width = source.Width * size / source.Height;
                height = size;
            }

            Bitmap target = new Bitmap(width, height);
            using (Graphics g = Graphics.FromImage(target))
            {
                g.CompositingQuality = CompositingQuality.HighSpeed;
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.CompositingMode = CompositingMode.SourceCopy;
                g.DrawImage(source, 0, 0, width, height);
                source = target;
            }
        }

        public void ResizeToRectangle(int width, int height)
        {
            Bitmap target = new Bitmap(width, height);
            using (Graphics g = Graphics.FromImage(target))
            {
                g.CompositingQuality = CompositingQuality.HighSpeed;
                g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                g.CompositingMode = CompositingMode.SourceCopy;

                int newWidth = width;
                int newHeight = (int)Math.Ceiling((double)source.Height * width / source.Width);

                int xOffset = 0;
                int yOffset = (height - newHeight) / 2;

                g.DrawImage(source, xOffset, yOffset, newWidth, newHeight);
                source = target;
            }
        }


        public void SaveAs(string filename)
        {
            source.Save(filename, ImageFormat.Jpeg);
        }
    }
}
From: admin <sun-info@internode.com.au>
Date: Tue, 08 Mar 2005 09:57:14 +0000
Subject: current status of gigaswift drivers in 2.6...
Message-Id: <200503082025.00094.sun-info@internode.com.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all.

I want to get a 2.6 gentoo system running on some b100s blades 
(UltraSPARC-IIe, dual gigaswift ethernet, ALI ide)

A 2.4 netboot image from gentoo comes up minus networking. Trawling the sparc 
linux lists (and *bsd) shows a distinct lack of movement on drivers for the 
gigaswift chipset.

Sun have released a driver for 2.4 (second from the bottom)
http://www.sun.com/products/networking/downloads.html

The source make at least one reference to 2.6, and this page
http://www.sun.com/download/products.xml?idA40b67e
suggests that it is the build options that prevent it from compiling rather 
than the driver code. Whilst that fairly unlikely to be the case, I was just 
wondering if anyone more knowledgeable has tried getting this to work on a 
2.6 kernel.

Thanks
Nick


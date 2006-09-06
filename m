From: Daniel Smolik <marvin@mydatex.cz>
Date: Wed, 06 Sep 2006 14:11:44 +0000
Subject: Re: TILO and others
Message-Id: <44FED720.6090005@mydatex.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090803020006010607040904"
List-Id: <sparclinux.vger.kernel.org>
References: <44FC960D.3040508@mydatex.cz>
In-Reply-To: <44FC960D.3040508@mydatex.cz>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803020006010607040904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hamish Greig napsal(a):
> On Tuesday 05 September 2006 17:45, Rene Rebe wrote:
> 
>>I used elftoaout + the piggyback helper in arch/sparc64.
> 
> 
> I too have successfully used these two for netbooting.
> hgg

Thanks, you kick me to rigt way. I use piggyback from sparc directory. I test 
before piggiback64 but that says nothing and I think that doesn't work.
But now I read source make simple patch  to display status of working piggyback 
and woala all works piggyback64 doesn't write new file but modify kenel directly.

			Thanks
					Dan


--------------090803020006010607040904
Content-Type: text/x-patch;
 name="piggyback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piggyback.patch"

--- linux-2.6.18-rc3/arch/sparc64/boot/piggyback.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.17.2/arch/sparc64/boot/piggyback.c	2006-09-05 19:59:37.000000000 +0200
@@ -45,6 +45,7 @@
 	FILE *map;
 	struct stat s;
 	int image, tail;
+
 	
 	if (stat (argv[3], &s) < 0) die (argv[3]);
 	map = fopen (argv[2], "r");
@@ -55,6 +56,7 @@
 		else if (!strcmp (buffer + 19, "_end\n"))
 		end = strtoul (buffer + 8, NULL, 16);
 	}
+	printf("start: 0x%x end: 0x%x \n",start,end);
 	fclose (map);
 	if ((image = open(argv[1],O_RDWR)) < 0) die(argv[1]);
 	if (read(image,buffer,512) != 512) die(argv[1]);
@@ -88,6 +90,7 @@
 		}
 		offset = i + (q - buffer) + 10;
 	}
+	
 	if (lseek(image, offset, 0) < 0) die ("lseek");
 	*(unsigned *)buffer = 0;
 	*(unsigned *)(buffer + 4) = 0x01000000;
@@ -101,8 +104,15 @@
 	if (write(image,buffer,12) != 12) die (argv[1]);
 	if (lseek(image, k - start + ((end + 32 + 8191) & ~8191), 0) < 0) die ("lseek");
 	if ((tail = open(argv[3],O_RDONLY)) < 0) die(argv[3]);
+	printf("Writing ...");
 	while ((i = read (tail,buffer,1024)) > 0)
+	{
 		if (write(image,buffer,i) != i) die (argv[1]);
+		printf(".");
+		
+	}	
+	printf(".done\n");
+	printf("%s updated \n",argv[1]);
 	if (close(image) < 0) die("close");
 	if (close(tail) < 0) die("close");
     	return 0;

--------------090803020006010607040904--

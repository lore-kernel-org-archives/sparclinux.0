From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Mon, 14 Feb 2005 15:56:13 +0000
Subject: size-differences of long(userspace) / long(kernel)
Message-Id: <Pine.LNX.4.61.0502141648360.6890@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

Is there any generic way in situations, where (pointers 
to) structs are transferred from user- to kernelspace and vice versa? 
Any struct containing a long int or a pointer will have a different 
size in kernel space! This usually happens when doing ioctls ...

I'm not sure, whether it causes any troubles, but, e.g., ifreq contains 
another struct (ifmap) that in turn contains long ints . Thus the size of 
ifreq is 32 byte in userspace and 40 byte in kernelspace. If an 
application reserves sizeof(ifreq) bytes, then lets the kernel initialize 
the struct, which in turn copies it back to userspace - and thus might 
overwrite 8bytes that were not reserved for that struct ... Oops :-)

Any thoughts?

Michael


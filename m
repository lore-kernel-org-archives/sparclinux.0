From: "Rev. G. Lim" <glim@sunsmoke.org>
Date: Tue, 20 Feb 2007 23:37:04 +0000
Subject: SILO limits and requirements
Message-Id: <200702202337.l1KNb42F020734@sunsmoke.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Greetings.

I have some SILO questions and hope that this is the correct list in which
to ask them. If not, I apologize; I got here from sparc-boot.org site.

Here goes:
1. Is it correct to say that SILO can only read kernels from ext2/3,
with UFS planned for the somewhat near future? IOW, it cannot boot a
kernel located on ReiserFS or XFS or JFS.

2. I understand the 3M limit on kernel size, and I understand that there
is a practical limit of 2.5M... I am using silo-1.4.13. Does that limit
come from SMALL_RELOC in Rules.make? If so, what is LARGE_RELOC for?

3. On my systems, of the several versions of silo, second.b has always
been just less than 64k in size. Would it be worth it to set SMALL_RELOC
to 0x2E0000 to gain an extra 384k? That would leave 128k for second.b,
instead of 512k. Would it be safe?

4. What's the practical limit on the size of an initrd? Is there any way
to increase it?

Thanks for reading! Please answer if you know. The answers don't seem 
to be directly available from the website.
-Greg Lim

PS. I am not subscribed to the list, but I will try to watch it. My email
address is like: (galima@saunasmoake.org) but it doesn't have the letter
'a' in it anywhere.


From: Jim Gifford <maillist@jg555.com>
Date: Tue, 03 Jan 2006 15:43:12 +0000
Subject: Re: SILO 1.4.10
Message-Id: <43BA9B90.50207@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

When I do that, I get the same problem. Also when the -m elf32_sparc is 
there, all the other files are different.

 cmp /boot/fd.b fd.b
/boot/fd.b fd.b differ: char 1, line 1

Which made me thing there was something else wrong elsewhere, I rebuild 
elftoaout as 32bit, and now everything works.

-- 
----
Jim Gifford
maillist@jg555.com


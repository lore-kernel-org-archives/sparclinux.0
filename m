From: Jim Gifford <maillist@jg555.com>
Date: Mon, 02 Jan 2006 23:58:40 +0000
Subject: Re: SILO 1.4.10
Message-Id: <43B9BE86.8080407@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I verified the only file not being built correctly is second.b. I used 
hexdump to create a hexdump of the second.b from silo-loaders-1.4.10 and 
the one I compiled. It looks like everything is shifted.

http://ftp.jg555.com/diff_of_hex_dump

-- 
----
Jim Gifford
maillist@jg555.com


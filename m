From: Ben Collins <ben.collins@ubuntu.com>
Date: Mon, 02 Jan 2006 22:44:01 +0000
Subject: Re: SILO 1.4.10
Message-Id: <1136241841.27583.59.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2006-01-02 at 14:12 -0800, Jim Gifford wrote:
> The problem is that there is no build error, but it just gives me an 
> error message when I run silo -f.
> 
> # silo -f
> /etc/silo.conf appears to be valid
> Fatal error: Corrupted /boot/second.b or second stage with incorrect version

Works fine for me. Try this:

cp first/{first,ultra,generic}.b /boot
cp second/second.b /boot
cp silo/silo /sbin/silo

silo -f


If that fails, then something is seriously wrong with your second.b
image.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux


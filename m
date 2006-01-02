From: Ben Collins <ben.collins@ubuntu.com>
Date: Mon, 02 Jan 2006 23:09:24 +0000
Subject: Re: SILO 1.4.10
Message-Id: <1136243364.27583.62.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <1136175018.27583.50.camel@grayson>
In-Reply-To: <1136175018.27583.50.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2006-01-02 at 14:51 -0800, Jim Gifford wrote:
> The same exact thing.

You are compiling stock source? I can't see binutils causing this
problem. Maybe it's elftoaout, but I've never seen anyone get it
compiled only to have it spit out that message.

You'll need to dig into this yourself. Use hexedit and see what's up
with second.b

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux


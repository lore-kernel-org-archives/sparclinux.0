From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Thu, 09 Jun 2011 23:03:22 +0000
Subject: Re: [PATCH][RFC] Sparc: Remove trigraph in die_if_kernel() message.
Message-Id: <20110609230322.GY11521@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.00.1106071627260.8844@swampdragon.chaosbits.net>
 <20110609.155943.162785602513776337.davem@davemloft.net>
In-Reply-To: <20110609.155943.162785602513776337.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: jj@chaosbits.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 09, 2011 at 03:59:43PM -0700, David Miller wrote:
> > If I'm not mistaken, that "??!" will be taken as a trigraph for "|" by the 
> > preprocessor, so the final string will end up either as
> >   "Penguin instruction from Penguin mode|?!"

Not without -trigraphs, which is not on by default...

> Applied, thanks Jesper :-)

BTW, idiomatic way to deal with those is to use \? instead of string concat...

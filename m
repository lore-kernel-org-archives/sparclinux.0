From: David Miller <davem@davemloft.net>
Date: Tue, 04 Jan 2011 02:56:09 +0000
Subject: Re: [PATCH] sparc: explicitly cast negative phandle checks to s32
Message-Id: <20110103.185609.71121011.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20101111224206.79239902@queued.net>
In-Reply-To: <20101111224206.79239902@queued.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 3 Jan 2011 19:26:38 -0700

> On Thu, Nov 11, 2010 at 10:42:06PM -0800, Andres Salomon wrote:
>> 
>> When we switched sparc from using 'int's to 'phandle's (which is a u32), we
>> neglected to do anything with the various checks for -1.  For those tests,
>> explicitly cast the phandles to s32.
>> 
>> My sparc machine is down, so I was unable to build-test this..
>> 
>> Signed-off-by: Andres Salomon <dilinger@queued.net>
> 
> Two hunks in this patch no longer apply as the code it touches appears
> to have been removed, but the rest applies and at least compiles.  I
> haven't boot tested it though.
> 
> Dave, I imagine this fix should go in via your tree, but I can pick it
> up if you prefer.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Indeed, I was hoping you would pick it up Grant, thanks :-)

Acked-by: David S. Miller <davem@davemloft.net>

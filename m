From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 08 Jun 2004 16:30:18 +0000
Subject: Re: [RFC] redundant checks in getdomainname
Message-Id: <20040608163018.GB10483@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200406071532.i57FWADo023297@voidhawk.shadowen.org>
In-Reply-To: <200406071532.i57FWADo023297@voidhawk.shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jun 07, 2004 at 04:32:10PM +0100, Andy Whitcroft wrote:

> We first bound the users buffer length by the current length of
> the domainname uts member.  This element by definition cannot be
> longer than __NEW_UTS_LEN, so the following check can never trigger.

Actually, if you look at this, the code handles one specific case:

   len >= __NEW_UTS_LEN + 1 
&& strlen(system_utsname.domainname) = __NEW_UTS_LEN  

In this case, an error is returned, which seems wrong since the user
has given us enough space to return the whole thing properly
terminated.

So the check is not meaningless.  I don't have access to the SunOS man
pages, but I'd guess this behaviour has something to do with what it
expects.

> Also can anyone tell me why these architectures have this call,
> the generic code implies that uname can be used to fetch this
> information and does not therefore supply an implmentation.

SunOS compatibility.

-- 
Keith M Wesolowski

From: David Miller <davem@davemloft.net>
Date: Fri, 13 Apr 2012 21:53:25 +0000
Subject: Re: [PATCH] sparc64: Fix bootup crash on sun4v.
Message-Id: <20120413.175325.1005068789147734885.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120413.150126.895680397991364654.davem@davemloft.net>
In-Reply-To: <20120413.150126.895680397991364654.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 13 Apr 2012 23:41:36 +0200

> On Fri, Apr 13, 2012 at 03:01:26PM -0400, David Miller wrote:
>> 
>> 
>> Register DS using device_initcall() insteal.
>> 
>> -subsys_initcall(ds_init);
>> +fs_initcall(ds_init);
> 
> Changelog and patch does not match?!?

Grrr... good catch.

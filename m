From: David Miller <davem@davemloft.net>
Date: Thu, 07 Dec 2017 18:05:13 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <20171207.130513.615954370120115050.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Thu, 7 Dec 2017 16:40:14 +0000

>> Can you please provide me with an example of an actual mdesc
>> entry that needs sanitization? I believe you are thinking of
>> passwords and crypto keys but I couldn't find any such entry
>> on any machine I have access to.
> 
> Dave, I still have to read from you on this.

I don't know, but based upon private communication we received from
Greg Onufer some might exist.

Please do a detailed audit of the mdesc properties that might contain
passwords or other sensitive issues, and please provide the results
of your audit on the list here.

Thank you.

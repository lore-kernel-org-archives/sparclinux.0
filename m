From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Thu, 14 Dec 2017 11:01:58 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <4ef9ccd2-1212-90f0-2549-65f96f58e88f@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>> Can you please provide me with an example of an actual mdesc
>>> entry that needs sanitization? I believe you are thinking of
>>> passwords and crypto keys but I couldn't find any such entry
>>> on any machine I have access to.
>> Dave, I still have to read from you on this.
> I don't know, but based upon private communication we received from
> Greg Onufer some might exist.
>
> Please do a detailed audit of the mdesc properties that might contain
> passwords or other sensitive issues, and please provide the results
> of your audit on the list here.
Alexandre Chartres did part of that audit for us: he pointed out 2 
sensitive mdesc keys that contain passwords and cryptographic keys.

I can't spend much more time on this patch. It's already out there in 
the mailing list archive for whoever wants to use it.

That said this sanitization task should be on top of your sparc todo 
list IMHO because the existing /dev/mdesc driver doesn't filter anything 
as of today, so it leaks critical/sensitive data to the OS.

All the best with fixing /dev/mdesc.

-eric

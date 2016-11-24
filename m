From: vincent@cojot.name
Date: Thu, 24 Nov 2016 21:26:27 +0000
Subject: Re: SILO Issues on an E4900
Message-Id: <alpine.LRH.2.20.1611241623420.20736@daltigoth.lasthome.solace.krynn>
List-Id: <sparclinux.vger.kernel.org>
References: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
In-Reply-To: <62477e32a682342782e652fcfdbf9fb5@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


A while back I stumbled onto an old post talking about the 'Illegal 
instruction' issue with SILO on serengeti machines:

http://helenos-blog.pavel-rimsky.cz/?p=3

Any thoughts?

Note that I have not personally verified that it works or not (I sold my 
US-IIICu sb2k some time ago already...)

My 2c,

Vincent

On Thu, 24 Nov 2016, John Paul Adrian Glaubitz wrote:

> On 11/24/2016 05:10 PM, David Miller wrote:
>> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Date: Thu, 24 Nov 2016 11:00:29 +0100
>>
>>> For SILO, Oracle has created several patches which port SILO to 64-bit (I extracted
>>> that patch and applied it to the Debian package) and other packages which improve
>>> SILO on modern sun4v machines.
>>
>> All of the changes which were submitted to this list I reviewed and
>> either they were poorly formed or did not apply cleanly at all.
>
> That doesn't sound too good :(.
>
>> Everything fell to /dev/null and the developers made no effort
>> whatsoever to address the feedback and make the patches actually apply
>> to the SILO git tree properly.
>>
>> The patches were not only poorly formed, or not able to apply to the
>> GIT tree, they were also extremely poorly documented with either a
>> very terse and vague commit message provided or none at all.  When
>> I would ask why a change was doing X or Y, I received no response
>> at all.
>
> Hmm. I have this small patch which enables 64-bit support. It's rather
> clean and I'll try to submit it later today to get at least some
> improvements.
>
> Adrian
>
> -- 
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

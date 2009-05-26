From: Robert Reif <reif@earthlink.net>
Date: Tue, 26 May 2009 02:01:26 +0000
Subject: Re: sparc32 boot problem (SCSI?)
Message-Id: <4A1B4D76.3040302@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1608E3.6040009@earthlink.net>
In-Reply-To: <4A1608E3.6040009@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> Josip Rodin wrote:
>> One thing that came up with one of my recent upgrades was the md 
>> subsystem
>> interfering with /dev/root, and that kind of a problem isn't 
>> mentioned in
>> the generic instructions. Does /dev/root point to the right device (same
>> major:minor as /dev/sda2) in your case?
>>
>>   
> I don't have md selected.  There is no /dev/root in either
> the working or broken version.  I'm running debian etch
> if that matters.
I'm trying to bisect this and have narrowed it down to
late in the merge window.  Unfortunately I can't easily narrow
it down further because module loading also broke during
the same time frame.

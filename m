From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 15 Jun 2017 15:34:01 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <3adcc5fa-6e64-13b1-8ad1-e4a43dcf716d@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 06/15/2017 11:23 AM, David Miller wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> Date: Thu, 15 Jun 2017 08:20:01 -0700
> 
>> On Thu, Jun 15, 2017 at 10:40:57AM -0400, Pavel Tatashin wrote:
>>> Guenter Roeck reported a problem that was introduced by early boot
>>> timestamp changes. Where: tick_get_frequency() returns 0.
>>>
>>> Guenter Roeck: could you please test if these patches fix the issue?
>>>
>> My tests pass with those patches applied, so
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Pushed to sparc-next, thanks for testing!
> 
> Pavel, maybe you can add qemu-sparc64 to your test matrix?

Guenter thank you very much for testing it so promptly.

I will setup qemu for sparc64 to test my future changes. This should be 
extremely useful.



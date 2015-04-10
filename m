From: chris hyser <chris.hyser@oracle.com>
Date: Fri, 10 Apr 2015 19:55:44 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <55282AC0.8050802@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 4/10/2015 3:25 PM, David Miller wrote:
> From: chris hyser <chris.hyser@oracle.com>
> Date: Fri, 10 Apr 2015 11:27:23 -0400
>
>> On 4/9/2015 7:06 PM, David Miller wrote:
>>> How will this work on T3, T2, and T1 which all neither have the
>>> "socket" mdesc nodes nor level 3 caches?
>>
>> The patch only works for sun4v and is only called in that path.
>
> T1, T2, and T3 are sun4v systems.
>
> I can't believe I'm having this conversation with an Oracle engineer.

Your mileage will vary. So you want a generic solution that works on platforms that do not have the key element required 
for this patch? Absent useful machine provided info, I'm guessing it will require some sort of hardcoded table.

-chrish


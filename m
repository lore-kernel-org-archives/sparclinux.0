From: Darren Hart <dvhart@linux.intel.com>
Date: Sat, 19 Mar 2011 09:04:17 +0000
Subject: Re: 38-git2-6 -- kernel/futex.c warning
Message-Id: <4D847191.7000806@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201103181932.p2IJW5cg002394@clem.clem-digital.net> <20110318.125808.233714688.davem@davemloft.net>
In-Reply-To: <20110318.125808.233714688.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org, mroos@linux.ee, sparclinux@vger.kernel.org



On 03/18/2011 12:58 PM, David Miller wrote:
> From: Pete Clements<clem@clem.clem-digital.net>
> Date: Fri, 18 Mar 2011 15:32:05 -0400 (EDT)
>
>> Fyi. Have been experiencing the below since 38-git2. Continual scrolling
>> such that cannot complete system startup. System is i386 UP, Debian "squeeze".
>
> Looks similar to the problems reported by Meelis, CC:'d

yes, and the same answer, see Steven Rostedts patch set from March 17th:

[PATCH 0/2 v2] [GIT PULL] futex: Fix WARN_ON trigging on UP

--
Darren

>
>> WARNING: at kernel/futex.c:786 wake_futex+0x21/0x70()
>> Hardware name: XPST450
>> Modules linked in: ipv6
>> Pid: 1045, comm: rndc Not tainted 2.6.38-git6 #1
>> Call Trace:
>> [<c101eba8>] ? warn_slowpath_common+0x78/0xb0
>> [<c1040b21>] ? wake_futex+0x21/0x70
>> [<c1040b21>] ? wake_futex+0x21/0x70
>> [<c101ebf9>] ? warn_slowpath_null+0x19/0x20
>> [<c1040b21>] ? wake_futex+0x21/0x70
>> [<c10429d9>] ? do_futex+0x629/0x950
>> [<c108f2a3>] ? d_kill+0x73/0xd0
>> [<c1042d78>] ? sys_futex+0x78/0x130
>> [<c107c2dd>] ? filp_close+0x4d/0x80
>> [<c11fa8bd>] ? syscall_call+0x7/0xb
>> ---[ end trace 595c935fe53c9cd0 ]---
>>
>> --
>> Pete Clements
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 02 Mar 2021 14:44:54 +0000
Subject: Re: [PATCH] sparc64: Fix opcode filtering in handling of no fault loads
Message-Id: <cacdc021-75cd-7325-0273-cc007a4767ff@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi!

On 3/1/21 4:05 PM, Rob Gardner wrote:
> On 3/1/21 5:56 AM, Anatoly Pugachev wrote:
>> On Mon, Mar 1, 2021 at 9:09 AM Rob Gardner <rob.gardner@oracle.com> wrote:
>>> is_no_fault_exception() has two bugs which were discovered via random
>>> opcode testing with stress-ng. Both are caused by improper filtering
>>> of opcodes.
>> Rob, tested on my ldom, works perfectly now...
>>
>> $ uname -a
>> Linux ttip 5.12.0-rc1-dirty #195 SMP Mon Mar 1 15:46:15 MSK 2021
>> sparc64 GNU/Linux
>>
>> $ stress-ng --opcode 1 --timeout 60 --metrics-brief
>> stress-ng: info:  [945] dispatching hogs: 1 opcode
>> stress-ng: info:  [945] successful run completed in 60.00s (1 min, 0.00 secs)
>> stress-ng: info:  [945] stressor       bogo ops real time  usr time
>> sys time   bogo ops/s   bogo ops/s
>> stress-ng: info:  [945]                           (secs)    (secs)
>> (secs)   (real time) (usr+sys time)
>> stress-ng: info:  [945] opcode            17847     60.00     27.45
>>   34.03       297.45       290.29
>>
>> Thank you for a quick fix.
> 
> 
> You're welcome. Please add your "tested-by" if you like.

Any chance we could get this patch into 5.12 and the stable kernels? (CC Greg)

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

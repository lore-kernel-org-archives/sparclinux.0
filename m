From: Anatoly Pugachev <matorola@gmail.com>
Date: Mon, 01 Mar 2021 12:56:53 +0000
Subject: Re: [PATCH] sparc64: Fix opcode filtering in handling of no fault loads
Message-Id: <CADxRZqxScpzebDEh+LjyKmsgoQErqB=Lie=JUX2WWN2NOzqPcQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1614577696-27586-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 1, 2021 at 9:09 AM Rob Gardner <rob.gardner@oracle.com> wrote:
>
> is_no_fault_exception() has two bugs which were discovered via random
> opcode testing with stress-ng. Both are caused by improper filtering
> of opcodes.

Rob, tested on my ldom, works perfectly now...

$ uname -a
Linux ttip 5.12.0-rc1-dirty #195 SMP Mon Mar 1 15:46:15 MSK 2021
sparc64 GNU/Linux

$ stress-ng --opcode 1 --timeout 60 --metrics-brief
stress-ng: info:  [945] dispatching hogs: 1 opcode
stress-ng: info:  [945] successful run completed in 60.00s (1 min, 0.00 secs)
stress-ng: info:  [945] stressor       bogo ops real time  usr time
sys time   bogo ops/s   bogo ops/s
stress-ng: info:  [945]                           (secs)    (secs)
(secs)   (real time) (usr+sys time)
stress-ng: info:  [945] opcode            17847     60.00     27.45
 34.03       297.45       290.29

Thank you for a quick fix.

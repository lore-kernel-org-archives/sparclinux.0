From: Dmitry Safonov <dima@arista.com>
Date: Wed, 06 Nov 2019 16:02:06 +0000
Subject: Re: [PATCH 34/50] sparc: Add show_stack_loglvl()
Message-Id: <40f70e6b-c3c6-34ee-45c9-573331851534@arista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-35-dima@arista.com>
 <20191105.193327.1393649190609263166.davem@davemloft.net>
In-Reply-To: <20191105.193327.1393649190609263166.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, mingo@kernel.org, jslaby@suse.com, pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, penguin-kernel@I-love.SAKURA.ne.jp, sparclinux@vger.kernel.org

On 11/6/19 3:33 AM, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Wed,  6 Nov 2019 03:05:25 +0000
> 
>> Currently, the log-level of show_stack() depends on a platform
>> realization. It creates situations where the headers are printed with
>> lower log level or higher than the stacktrace (depending on
>> a platform or user).
>>
>> Furthermore, it forces the logic decision from user to an architecture
>> side. In result, some users as sysrq/kdb/etc are doing tricks with
>> temporary rising console_loglevel while printing their messages.
>> And in result it not only may print unwanted messages from other CPUs,
>> but also omit printing at all in the unlucky case where the printk()
>> was deferred.
>>
>> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
>> an easier approach than introducing more printk buffers.
>> Also, it will consolidate printings with headers.
>>
>> Introduce show_stack_loglvl(), that eventually will substitute
>> show_stack().
>>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks for the review and time, David!

-- 
          Dmitry

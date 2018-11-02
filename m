From: David Miller <davem@davemloft.net>
Date: Fri, 02 Nov 2018 06:04:27 +0000
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
Message-Id: <20181101.230427.364286844194487248.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1541080391-3890-4-git-send-email-firoz.khan@linaro.org>
        <20181101.133315.47887636039827313.davem@davemloft.net>
        <CALxhOnieTqFzs-D9mNB5nL0=iPGFE92Gwm-Coft7D0_7RJgHiQ@mail.gmail.com>
In-Reply-To: <CALxhOnieTqFzs-D9mNB5nL0=iPGFE92Gwm-Coft7D0_7RJgHiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: firoz.khan@linaro.org
Cc: sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org

From: Firoz Khan <firoz.khan@linaro.org>
Date: Fri, 2 Nov 2018 11:09:57 +0530

> On Fri, 2 Nov 2018 at 02:03, David Miller <davem@davemloft.net> wrote:
>>
>> If sys_nis_syscall for the compat syscall shows up in a situation where the
>> native 32-bit syscall does have an entry, that's a BUG and the script should
>> point this out so that the bug can be fixed.
> 
> syscall.tbl is the input to the script, so the developers has the
> responsibility to fill the table
> properly. I don't know, we have to write a script which has to be
> smart enough to catch the
> wrong syscall entries.

It does not need anything "smart", it just needs to see that
sys_nis_syscall in the "compat" column just as my eyes noticed
them in your patch.

It can be completely automated.

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 14 Feb 2005 19:41:07 +0000
Subject: Re: Too big 2.6 kernels on SS5
Message-Id: <Pine.SOC.4.61.0502141526050.12189@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502141245530.25663@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks, I got it to boot.

> Kill these config options.
>
>> CONFIG_KALLSYMS=y

No way to kill this -- ???

> Don't need either of these.
>
>> CONFIG_DUMMY_CONSOLE=y

Can't diable this.

> These can be modules, right?
>
>> CONFIG_INPUT_MOUSEDEV=y
>
>> CONFIG_SOUND_GAMEPORT=y
>
>> CONFIG_INPUT_MOUSE=y

No, they are static.

>> CONFIG_RAMFS=y

Can't disable this.

> Disable this, it adds a lot to the kernel.
>
>> CONFIG_DEBUG_BUGVERBOSE=y

Can't disable this either.

-- 
Meelis Roos (mroos@linux.ee)

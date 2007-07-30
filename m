From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 30 Jul 2007 00:09:33 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <646765f40707291709g4706872csc9b37006f0bd67a5@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 7/29/07, David Miller <davem@davemloft.net> wrote:
> The floppy driver cannot be built as a module on sparc32, you must
> build it in statically because it references an interrupt handler
> which must be coded in assembler which therefore cannot be easily
> exported to modules.

Stupid question, but: Why is it possible to select it to compile as a
module when it cannot?

-- 

Julian Calaby

Email: julian.calaby@gmail.com

From: "Julian Calaby" <julian.calaby@gmail.com>
Date: Mon, 20 Aug 2007 23:39:08 +0000
Subject: Re: Problems starting up ...
Message-Id: <646765f40708201639l18defecewb07768e75aec25d3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200708202317.48014.Stefan.Sablatnoeg@gmx.de>
In-Reply-To: <200708202317.48014.Stefan.Sablatnoeg@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 8/21/07, Stefan Sablatn=F6g <Stefan.Sablatnoeg@gmx.de> wrote:
> My questions are:
> - Is there any further trick in using the serial console than to configure
>   CONFIG_SERIAL_SUNZILOG=3Dy and
>   CONFIG_SERIAL_SUNZILOG_CONSOLE=3Dy ?
>   what about CONFIG_SERIAL_CORE vs. CONFIG_SERIAL_SUNCORE have them both
>   or only the sun part?

If the serial console is like the serial console on i386, you have to
set it up (pass a commandline argument to the kernel) before it will
work.

Also, do you have another console type enabled? e.g. the PROM console
or a framebuffer console? - that may fix your problems.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com

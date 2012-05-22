From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 22 May 2012 06:28:55 +0000
Subject: Re: How to recognize a LEON CPU?
Message-Id: <4FBB3227.2060504@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521162253.GB5733@merkur.ravnborg.org>
In-Reply-To: <20120521162253.GB5733@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
> Who is the relevant Gaisler contact person these days for Linux stuff?
> I sometimes uses Daniel, sometimes Konrad.

The software groups leader is Daniel, I also
work on linux if there tasks to do, so both
can be mailed...
-- Konrad

>
> I can just add both of you - this is no problem.
> As I plan to update the LEON integration it would be good
> to have in place.
>
> Anyway - the real question..
>
> In head_32.S I need very early on to determine the CPU type,
> so I can distingush between LEON and SUN.
> This is due to LEON using a different ASI for mmuregs
> as discussed in another mail.
>
> I assume this can be determinded from PSR.
> If this is correct - then what values shall I use
> to determine if the relevant cpu is LEON or SUN?
>
> 	Sam
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


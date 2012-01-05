From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 05 Jan 2012 02:25:32 +0000
Subject: Re: SPARC32: forced setting of mode of SUN4M per-cpu timers
Message-Id: <772731325730332@web77.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
References: <1325727738.1385.3.camel@hp>
In-Reply-To: <1325727738.1385.3.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Thanks, Julian!

Kirill

05.01.2012, 05:53, "Julian Calaby" <julian.calaby@gmail.com>:
> Hi Kirill,
>
> I'll leave others to comment on the actual contents of the patch, but
> you've made a couple of rookie mistakes in submitting this patch.
>
> Firstly, make sure you put [PATCH] at the start of the subject of the
> patch as it makes it easier for people to spot patches as opposed to
> general discussion.
>
> On Thu, Jan 5, 2012 at 12:42, Kirill Tkhai <tkhai@yandex.ru> wrote:
>
>> =9ASPARC32: forced setting of mode of SUN4M per-cpu timers
>>
>> =9ASUN4M per-cpu timers have two modes of work. These are timer mode and
>> =9Acounter mode. SPARC32 doesn't write anything to the register, which is
>> =9Aconnected with mode choice. So, the mode is chosen by bootloader. This
>> =9Apatch forces to use timer mode from the kernel and to be independent =
of
>> =9Abootloader.
>>
>> =9AI had this problem with OpenBIOS. Timers don't tick and kernel fails =
on
>> =9AQEMU, when it's compiled with SMP support. The path fixes problem.
>
> Spelling mistake: "patch" not "path"
>
> You're missing your Signed-off-by: line. You must have a line at the
> bottom of your patch summary like the following:
>
> Signed-off-by: J Random Developer <jrdeveloper@example.com>
>
> Thanks,
>
> --
> Julian Calaby
>
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/
> .Plan: http://sites.google.com/site/juliancalaby/

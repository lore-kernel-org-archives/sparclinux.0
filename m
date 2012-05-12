From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 12 May 2012 07:12:03 +0000
Subject: Re: PATCH [0/14] sparc32: removal of sun4c platform support
Message-Id: <CAGRGNgX9SNDeXyciS_B=p5CPpS1rZOGeXk=HQXK48ByG71MJEw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120511213143.GA1518@merkur.ravnborg.org>
In-Reply-To: <20120511213143.GA1518@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi Sam,

On Sat, May 12, 2012 at 5:00 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi David et al.
>>
>> This opens up some exciting possibilities, for example we
>> can also ditch Cypress sun4m support and therefore eliminate
>> the software integer multiply/divide stuff and thus build
>> the kernel with -mcpu=3Dv8 or similar.
>
> According to this wikipedia article:
>
> =A0 =A0 http://en.wikipedia.org/wiki/SPARCstation
>
> Then Cypres is only used in:
>
> o SPARCstation 2

I feel duty bound to point out that we've already eliminated support
for that box as it's sun4c.

Which leaves only these boxes which can take the Cypress CPUs:

> o SPARCserver 6xxMP

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/

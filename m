From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: Mon, 17 May 2004 22:18:43 +0000
Subject: Re: [SPARC64] Need help..
Message-Id: <20040517221843.GA9136@shookay.newview.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
In-Reply-To: <Pine.LNX.4.58L.0405171051230.1247@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 18, 2004 at 12:06:10AM +0200, Wojciech 'Sas' Cieciwa wrote:
> Nope, this patch is applayed in cset-20050517_*
> and I still got this message.

Alright so if you still get this, it means:
1 - you're not crosscompiling (right?)
2 - you've got a real problem :-)

It's strange because the "current_thread_info_reg" error is supposed to be
skipped by this piece of code in modpost.c (if I understand the whole thing
correctly):

#ifdef STT_REGISTER
                if (info->hdr->e_machine = EM_SPARC ||
                    info->hdr->e_machine = EM_SPARCV9) {
                        /* Ignore register directives. */
                        if (ELF_ST_TYPE(sym->st_info) = STT_REGISTER)
                                break;
                }
#endif

So do some debug, add some printfs: print e_machine and check whether it
matches EM_SPARC* and also check sym->st_info.

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --

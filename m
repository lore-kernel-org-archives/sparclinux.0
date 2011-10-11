From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 11 Oct 2011 12:16:01 +0000
Subject: Re: [PATCH 4/4] kernel,debug: SPARC KGDB stub strcpy fix
Message-Id: <4E943381.5060401@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
In-Reply-To: <1317390450-5982-5-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Konrad Eisele <konrad@gaisler.com>
> Date: Fri, 30 Sep 2011 15:47:30 +0200
> 
>> Works aroung the fact that strcpy in SPARC returns 0.
>>
>> Signed-off-by: Konrad Eisele <konrad@gaisler.com>
> 
> Fix strcpy() on SPARC instead please.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
It is a gcc optimization. strcpy(p,"string") is converted to memcpy(p,7).
I could think of 2 ways:
- fix memcpy() so that it returns the dest-pointer instead of 0. (However
  there might be a reason that it returns 0 ...
- keep the "kernel,debug: SPARC KGDB stub strcpy fix" patch but change the
  summary of the patch to:
    Works aroung the fact that strcpy with a constant string is
    converted to memcpy by gcc and that  memcpy in SPARC returns 0.

I'll send the 2 possibilities as a reply in a moment.

-- Konrad


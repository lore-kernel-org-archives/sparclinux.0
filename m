From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Jun 2009 07:11:16 +0000
Subject: Re: LEON SPARC git repository
Message-Id: <20090606071116.GA25951@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4A27926C.5010501@gaisler.com>
In-Reply-To: <4A27926C.5010501@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Fri, Jun 05, 2009 at 11:57:48AM +0200, Konrad Eisele wrote:
> Hi Sam,
> Thanks for the clarification, I'll send the divided patches next week.

A few other things you can do to ease review/integration is:
1) run all patches through checkpatch (see scripts/checkpatch)
   Try to address the relevant warning/errors.
   It is not a prerequisite you are down to 0/0 - but
   it eases review that you have addressed the obvious things
   that checkpatch can warn you about.
2) Run the code through sparse.
   Use "make C=3D2".
   Again it is not a prereqisite that you are down to 0 warnings.
   But at least having declaration for all functions and
   variables are a must.
   And fix all usages so you use NULL and not 0 for a null pointer.
   One main reason to do so is that you then are not faced with
   a lot of janitorial mails doing so after you have had your
   code applied.

   To get sparse you should clone this version of it:
   http://git.kernel.org/?p=DEvel/sparse/chrisl/sparse.git;a=3Dsummary

   This is the most updated version atm.

   Do not be shy and ask for help if you cannot dechiper the warnings.

	Sam

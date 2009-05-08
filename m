From: Andi Kleen <andi@firstfloor.org>
Date: Fri, 08 May 2009 19:18:44 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <878wl7o12j.fsf@basil.nowhere.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
	<904b25810905061146ged374f2se0afd24e9e3c1f06@mail.gmail.com>
	<20090506212913.GC4861@elte.hu>
	<904b25810905061446m73c42040nfff47c9b8950bcfa@mail.gmail.com>
	<20090506215450.GA9537@elte.hu>
	<904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com>
In-Reply-To: <904b25810905061508n6d9cb8dbg71de5b1e0332ede7@mail.gmail.com> (Markus Gutschke's message of "Wed, 6 May 2009 15:08:40 -0700")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-5"
Content-Transfer-Encoding: base64
To: =?iso-8859-1?Q?Markus_Gutschke_=28=DC=D2=D0=29?= <markus@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

Ik1hcmt1cyBHdXRzY2hrZSAo3NLQKSIgPG1hcmt1c0Bnb29nbGUuY29tPiB3cml0ZXM6Cj4KPiBU
aGVyZSBhcmUgYSBsYXJnZSBudW1iZXIgb2Ygc3lzdGVtIGNhbGxzIHRoYXQgIm5vcm1hbCIgQy9D
KysgY29kZSB1c2VzCj4gcXVpdGUgZnJlcXVlbnRseSwgYW5kIHRoYXQgYXJlIG5vdCBzZWN1cml0
eSBzZW5zaXRpdmUuIEEgdHlwaWNhbAo+IGV4YW1wbGUgd291bGQgYmUgZ2V0dGltZW9mZGF5KCku
CgpBdCBsZWFzdCBvbiB4ODYtNjQgZ2V0dGltZW9mZGF5KCkgKGFuZCB0aW1lKDIpKSB3b3JrIGlu
c2lkZSBzZWNjb21wIGJlY2F1c2UgCnRoZXkncmUgdnN5c2NhbGxzIHRoYXQgcnVuIGluIHJpbmcg
MyBvbmx5LgoKLUFuZGkKCi0tIApha0BsaW51eC5pbnRlbC5jb20gLS0gU3BlYWtpbmcgZm9yIG15
c2VsZiBvbmx5LgotLQpUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGlu
ZSAidW5zdWJzY3JpYmUgc3BhcmNsaW51eCIgaW4KdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1h
am9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcKTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCAgaHR0cDovL3Zn
ZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5odG1s

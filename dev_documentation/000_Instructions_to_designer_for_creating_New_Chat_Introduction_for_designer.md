# Instructions to designer for creating a New Chat Introduction for the designer

Now for some risk mitigation planning on the designer side.

You as the designer (W3D) chat have been fantastic - but this chat is now very
long indeed and, like the coder chat before it, seems likely to degrade or cease
functioning suddenly without prior notice. That is a bad thing for me, because
when it happens I lose the reasoning, judgement, and history that live only in
this chat and were never written into the controlling documents. The coder chat
gave me one scare already; I would rather secure the designer handover while you
are still sharp.

Can you please draft a really excellent introduction for your (likely memoryless)
successor designer chat, with a view to providing (and/or referencing) all the
background, context, rules, decisions, and reasoning the successor designer will
need to become immediately productive and to hold the design line the way this
chat has.

Keep it lean and directive - it should point into the existing documents with a
clear reading order, not re-summarise them. Assume the successor will read the
controlling documents; your job is to orient, not duplicate. The greatest risk is
a successor drowning in context; the converse risk is one starved of it.

Note the naming and versions of the current documents (they are re-attached
here). Call it `111_New_Chat_Introduction_for_Designer_v1.0.md`, matching the
coder introduction's naming and capitalisation.

Include information in sections. Among them:

**Where we are, in one line, up top.**
State the current project position and the immediate next designer action before
anything else, so the successor knows where it is in the arc before it reads a
single document. Orientation before detail. Note that the coder handover is done
and the coder is drafting or has drafted its own successor introduction, so the
successor designer is not blocked on it.

**Reading order.**
A memoryless chat handed multiple documents totalling thousands of lines will not
know which to read first, what is controlling vs informative, or where it is in
the arc. Give an explicit ordered reading path, marking each document as
controlling or informative, with a one-line reason to read each. This is a guided
entry, not a catalogue. The coder wrote its own; this is the designer's, and the
reading order may legitimately differ because the designer's job differs.

**The designer's role and its boundaries.**
What W3D does and does not do, drawn from the charter but stated for a successor
who has not yet read it: authors specifications, scopes, reviews, and harness
design; verifies claims against source with file and line; does not write
production code; does not build, run, or commit. Crucially, capture the working
relationship as it actually operates - the three-way W3X/W3D/W3C loop, that all
traffic passes through W3X, and that the designer's primary instrument is
skepticism, not agreement.

**Design reasoning that is not in the documents.**
This is the designer equivalent of the coder's tacit knowledge, and it is the
most valuable thing you can leave. The controlling documents record what was
decided; they do not always record why, or what was rejected and why. Capture the
reasoning behind the load-bearing decisions - for example why proper chroma over
luma-on-chroma, why the grid step is a required parameter with no default, why
Schedule B needs a quality gate rather than being adopted on authority, why FMA
is excluded from the AVX2 object, why the structural H.262 proof was preferred to
a clause citation. A successor that knows the decisions but not their reasoning
will re-litigate settled questions or reverse them under pressure.

**How the design was verified - the source-checking discipline.**
Record that repeated verification against the actual HolyWu source (and the
standards) caught several errors that plausible-sounding reasoning had produced -
the step-4 grid, the chroma-steps-not-by-subsampling trap, HolyWu running the
luma filter on chroma, the offset-attribution inversion. This is the single
habit most responsible for the design's quality, and a successor must inherit it
as a reflex, not a suggestion. Name where the cached source lives or how to
re-fetch it if you know.

**What will bite the successor designer.**
Separate from settled questions, a short list of active hazards specific to the
designer role - traps a plausible-but-wrong designer move would spring. Framed as
"if you are about to do X, don't, because Y." For example: promoting a coder
finding to a settled decision without W3X ratification; letting a measurement-
gated question be closed by argument instead of evidence; approving a delivery
that would let a scope pass before its oracle exists; drifting a cross-reference
or version number silently.

**What you suspect isn't written down.**
Explicitly flag any context you hold that you suspect is NOT captured in the
controlling documents. This is exactly what I cannot recover once this chat
stops. If you are unsure whether something made it into the record, name it here
rather than assume it did. Include the state of any open threads between us -
what is settled, what is measurement-gated, what is deferred, and what is merely
possibility - since losing that classification is the failure I fear most.

**First response expected from the successor.**
As with the coder introduction, make the successor prove orientation before
producing design work: state the documents and versions received, which are
controlling, the current milestone and next designer action, and any mismatch or
ambiguity blocking work. Do not re-summarise; demonstrate that it knows where the
project is and what governs it.

Just so you are aware, one of the things I fear greatest is loss of goals,
objectives, context, knowledge, experience, decisions, rules, status, etc from
one chat to the next. From experience, human project handovers hurt projects, and
so does this equivalent; I recall (only once recently) abandoning a new AI chat
which was somehow unable to perform. The designer role is where the project's
judgement lives, so a weak designer handover is more dangerous to the project
than a weak coder one - the coder implements a bounded scope, but the designer
guards the whole line.

Keep it to roughly the length of the coder introduction - lean enough that a
successor actually obeys the reading route, full enough to preserve the
perishable reasoning.

Before doing anything, your thoughts?

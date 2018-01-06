package javathreads.examples.ch02;

public interface CharacterSourse{
	public void addCharacterListener(CharacterListener cl);
	public void removeCharacterListener(CharacterListener cl);
	public void nextCharacter();
}